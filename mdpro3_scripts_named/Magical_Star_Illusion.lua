--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔力星幻像  (ID: 18752707)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上的怪兽数量是对方场上的怪兽数量以下的场合才能发动。自己以及对方场上的怪兽的攻击力直到回合结束时上升那怪兽的控制者场上的怪兽的等级合计×100。
--[[ __CARD_HEADER_END__ ]]

--マジカル・スター・イリュージョン
function c18752707.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c18752707.condition)
	e1:SetTarget(c18752707.target)
	e1:SetOperation(c18752707.activate)
	c:RegisterEffect(e1)
end
function c18752707.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)<=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)
end
function c18752707.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c18752707.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	local val1=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil):GetSum(Card.GetLevel)*100
	local val2=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil):GetSum(Card.GetLevel)*100
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		if tc:IsControler(tp) then
			e1:SetValue(val1)
		else
			e1:SetValue(val2)
		end
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
