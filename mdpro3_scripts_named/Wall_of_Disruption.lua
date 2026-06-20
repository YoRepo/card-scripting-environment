--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 分断之壁  (ID: 58169731)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时才能发动。对方场上的全部攻击表示怪兽的攻击力下降对方场上的怪兽数量×800。
--[[ __CARD_HEADER_END__ ]]

--分断の壁
function c58169731.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c58169731.condition)
	e1:SetTarget(c58169731.target)
	e1:SetOperation(c58169731.activate)
	c:RegisterEffect(e1)
end
function c58169731.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c58169731.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK)
end
function c58169731.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c58169731.filter,tp,0,LOCATION_MZONE,1,nil) end
end
function c58169731.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c58169731.filter,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	local atk=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)*800
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
