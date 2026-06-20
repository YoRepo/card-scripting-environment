--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 光角幻兔  (ID: 25795273)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Wyrm
-- Level 3
-- ATK 1600 | DEF 1000
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，场上的怪兽的攻击力·守备力下降那怪兽的等级或者阶级×300。
--[[ __CARD_HEADER_END__ ]]

--イルミラージュ
function c25795273.initial_effect(c)
	--atk down
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(c25795273.val)
	c:RegisterEffect(e1)
	--def down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetValue(c25795273.val)
	c:RegisterEffect(e2)
end
function c25795273.val(e,c)
	if c:IsType(TYPE_XYZ) then return c:GetRank()*-300
	else
		return c:GetLevel()*-300
	end
end
