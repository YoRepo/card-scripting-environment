--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 打一仗骑士  (ID: 18444902)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 0
--
-- Effect Text:
-- 对方的卡的效果让自己的魔法·陷阱卡的发动无效的场合，把这张卡从手卡送去墓地才能发动。给与对方基本分1500分伤害。
--[[ __CARD_HEADER_END__ ]]

--タタカワナイト
function c18444902.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18444902,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_CHAIN_NEGATED)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c18444902.damcon)
	e1:SetCost(c18444902.damcost)
	e1:SetTarget(c18444902.damtg)
	e1:SetOperation(c18444902.damop)
	c:RegisterEffect(e1)
end
function c18444902.damcon(e,tp,eg,ep,ev,re,r,rp)
	local de,dp=Duel.GetChainInfo(ev,CHAININFO_DISABLE_REASON,CHAININFO_DISABLE_PLAYER)
	return de and dp~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp==tp
end
function c18444902.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e)
		and e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c18444902.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1500)
end
function c18444902.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
