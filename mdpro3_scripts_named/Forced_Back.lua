--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 反冲  (ID: 43340443)
-- Type: Trap / Flip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 怪兽的召唤·反转召唤无效，那只怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--キックバック
function c43340443.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON)
	e1:SetCondition(aux.NegateSummonCondition)
	e1:SetTarget(c43340443.target)
	e1:SetOperation(c43340443.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON)
	c:RegisterEffect(e2)
end
function c43340443.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,eg,1,0,0)
end
function c43340443.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg:GetFirst())
	Duel.SendtoHand(eg,nil,REASON_EFFECT)
end
