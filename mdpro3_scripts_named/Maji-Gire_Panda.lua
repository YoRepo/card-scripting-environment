--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 动真格的熊猫  (ID: 60102563)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1000 | DEF 800
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，每次场上的兽族怪兽被破坏，这张卡攻击力上升500。
--[[ __CARD_HEADER_END__ ]]

--本気ギレパンダ
function c60102563.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60102563,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c60102563.atkcon)
	e1:SetOperation(c60102563.atkop)
	c:RegisterEffect(e1)
end
function c60102563.cfilter(c)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP) and bit.band(c:GetPreviousRaceOnField(),RACE_BEAST)~=0
end
function c60102563.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c60102563.cfilter,1,nil)
end
function c60102563.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(500)
		c:RegisterEffect(e1)
	end
end
