--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 亚马逊弩弓队  (ID: 67987611)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 4
--
-- Effect Text:
-- 只有在对方进行攻击宣言，且自己场上存在名称中含有「亚马逊」字样的怪兽时这张卡才能发动。将对方场上所有怪兽都变成表向攻击表示（此时反转不发动），攻击力下降500点。对方所有的怪兽都必须进行攻击。
--[[ __CARD_HEADER_END__ ]]

--アマゾネスの弩弓隊
function c67987611.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c67987611.condition)
	e1:SetTarget(c67987611.target)
	e1:SetOperation(c67987611.activate)
	c:RegisterEffect(e1)
end
function c67987611.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4)
end
function c67987611.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(c67987611.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c67987611.filter(c)
	return not c:IsPosition(POS_FACEUP_ATTACK)
end
function c67987611.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c67987611.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c67987611.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c67987611.filter,tp,0,LOCATION_MZONE,nil)
	Duel.ChangePosition(g,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
	local fg=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	local tc=fg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_MUST_ATTACK)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=fg:GetNext()
	end
end
