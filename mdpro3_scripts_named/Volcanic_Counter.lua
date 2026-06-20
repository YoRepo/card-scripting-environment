--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 火山反击兽  (ID: 66436257)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 300 | DEF 1300
-- Setcode: 50
--
-- Effect Text:
-- 自己受到战斗伤害时，墓地存在的这张卡从游戏中除外。那个时候，自己墓地有「火山反击兽」以外的炎属性怪兽存在的场合，给与对方基本分和自己受到的战斗伤害相同的伤害。
--[[ __CARD_HEADER_END__ ]]

--ヴォルカニック・カウンター
function c66436257.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66436257,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c66436257.condition)
	e1:SetTarget(c66436257.target)
	e1:SetOperation(c66436257.operation)
	c:RegisterEffect(e1)
end
function c66436257.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c66436257.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,tp,LOCATION_GRAVE)
end
function c66436257.filter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and not c:IsCode(66436257)
end
function c66436257.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)~=0
		and Duel.IsExistingMatchingCard(c66436257.filter,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.Damage(1-tp,ev,REASON_EFFECT)
	end
end
