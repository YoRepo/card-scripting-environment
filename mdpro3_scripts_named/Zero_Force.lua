--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 零之力  (ID: 17521642)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的怪兽从游戏中除外时才能发动。场上表侧表示存在的全部怪兽的攻击力变成0。
--[[ __CARD_HEADER_END__ ]]

--ゼロ・フォース
function c17521642.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_REMOVE)
	e1:SetCondition(c17521642.condition)
	e1:SetTarget(c17521642.target)
	e1:SetOperation(c17521642.operation)
	c:RegisterEffect(e1)
end
function c17521642.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
end
function c17521642.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c17521642.cfilter,1,nil,tp)
end
function c17521642.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c17521642.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c17521642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c17521642.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
