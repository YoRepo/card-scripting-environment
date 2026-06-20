--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 侵入魔鬼的魔细胞  (ID: 54338958)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 4106
--
-- Effect Text:
-- 自己场上没有怪兽存在的场合，这张卡可以从手卡特殊召唤。这张卡不能为名字带有「侵入魔鬼」的怪兽的上级召唤以外而解放，也不能作为同调素材。
--[[ __CARD_HEADER_END__ ]]

--インヴェルズの魔細胞
function c54338958.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c54338958.spcon)
	c:RegisterEffect(e1)
	--cannot release
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UNRELEASABLE_SUM)
	e3:SetValue(c54338958.sumlimit)
	c:RegisterEffect(e3)
	--cannot be synchro material
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c54338958.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c54338958.sumlimit(e,c)
	return not c:IsSetCard(0x100a)
end
