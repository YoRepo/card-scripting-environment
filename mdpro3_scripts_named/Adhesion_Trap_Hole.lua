--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 黏着的落穴  (ID: 62325062)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 76
--
-- Effect Text:
-- 对方对怪兽的召唤·反转召唤·特殊召唤成功时才能发动。那怪兽只要在场上表侧表示存在，原本攻击力变成一半数值。
--[[ __CARD_HEADER_END__ ]]

--粘着落とし穴
function c62325062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c62325062.target)
	e1:SetOperation(c62325062.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c62325062.filter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(1-tp)
end
function c62325062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c62325062.filter,1,nil,tp) end
	Duel.SetTargetCard(eg)
end
function c62325062.filter2(c,e,tp)
	return c:IsFaceup() and c:IsSummonPlayer(1-tp) and c:IsRelateToEffect(e)
end
function c62325062.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c62325062.filter2,nil,e,tp)
	local tc=g:GetFirst()
	while tc do
		local atk=math.ceil(tc:GetBaseAttack()/2)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
