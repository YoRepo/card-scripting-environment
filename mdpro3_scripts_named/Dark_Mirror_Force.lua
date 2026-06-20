--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 邪恶防护罩 -暗黑之力-  (ID: 20522190)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方怪兽的攻击宣言时才能发动。对方场上守备表示存在的怪兽全部从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--邪悪なるバリア －ダーク・フォース－
function c20522190.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c20522190.condition)
	e1:SetTarget(c20522190.target)
	e1:SetOperation(c20522190.activate)
	c:RegisterEffect(e1)
end
function c20522190.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c20522190.filter(c)
	return c:IsDefensePos() and c:IsAbleToRemove()
end
function c20522190.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c20522190.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c20522190.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c20522190.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c20522190.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
