--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 巨大土瓶草  (ID: 82116191)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1850 | DEF 700
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，每次场上存在的植物族怪兽被送去墓地，这张卡的攻击力上升200。
--[[ __CARD_HEADER_END__ ]]

--ギガント・セファロタス
function c82116191.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82116191,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c82116191.atkcon)
	e1:SetOperation(c82116191.atkop)
	c:RegisterEffect(e1)
end
function c82116191.filter(c)
	return c:IsPreviousPosition(POS_FACEUP) and bit.band(c:GetPreviousRaceOnField(),RACE_PLANT)~=0 and c:IsRace(RACE_PLANT) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c82116191.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c82116191.filter,1,nil)
end
function c82116191.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
