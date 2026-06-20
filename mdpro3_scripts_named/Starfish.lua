--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 海星  (ID: 44717069)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 3
-- ATK 300 | DEF 300
--
-- Effect Text:
-- 1回合1次，自己的主要阶段时才能发动。自己场上的全部「海星」的等级上升1星。
--[[ __CARD_HEADER_END__ ]]

--スターフィッシュ
function c44717069.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(44717069,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c44717069.target)
	e1:SetOperation(c44717069.operation)
	c:RegisterEffect(e1)
end
function c44717069.filter(c)
	return c:IsFaceup() and c:IsCode(44717069)
end
function c44717069.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44717069.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c44717069.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c44717069.filter,tp,LOCATION_MZONE,0,nil)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
