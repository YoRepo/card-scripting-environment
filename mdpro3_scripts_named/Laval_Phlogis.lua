--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 熔岩燃素人  (ID: 89609515)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 4
-- ATK 1700 | DEF 800
-- Setcode: 57
--
-- Effect Text:
-- 这张卡被送去墓地时，自己场上表侧表示存在的全部名字带有「熔岩」的怪兽的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--ラヴァル・フロギス
function c89609515.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89609515,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetOperation(c89609515.operation)
	c:RegisterEffect(e1)
end
function c89609515.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x39)
end
function c89609515.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c89609515.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
