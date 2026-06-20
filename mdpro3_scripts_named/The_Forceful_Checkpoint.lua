--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 检问  (ID: 94861297)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时才能发动。对方手卡全部确认，那之中有怪兽卡的场合，那次攻击无效。那之后，自己从对方手卡选1只怪兽丢弃。
--[[ __CARD_HEADER_END__ ]]

--検問
function c94861297.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c94861297.condition)
	e1:SetTarget(c94861297.target)
	e1:SetOperation(c94861297.activate)
	c:RegisterEffect(e1)
end
function c94861297.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c94861297.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c94861297.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		Duel.ConfirmCards(tp,g)
		local tg=g:Filter(Card.IsType,nil,TYPE_MONSTER)
		if tg:GetCount()>0 and Duel.NegateAttack() then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
			local hg=tg:Select(tp,1,1,nil)
			Duel.SendtoGrave(hg,REASON_EFFECT+REASON_DISCARD)
		end
		Duel.ShuffleHand(1-tp)
	end
end
