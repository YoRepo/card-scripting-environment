--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 龙骑士 黑魔术师  (ID: 41721210)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2500
-- Setcode: 4258
--
-- Effect Text:
-- 「黑魔术师」＋龙族怪兽
-- ①：这张卡的卡名只要在场上·墓地存在当作「黑魔术师」使用。
-- ②：只要这张卡在怪兽区域存在，自己场上的魔法·陷阱卡不会被对方的效果破坏，对方不能把那些作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--竜騎士ブラック・マジシャン
function c41721210.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,46986414,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),1,true,true)
	--change name
	aux.EnableChangeCode(c,46986414,LOCATION_MZONE+LOCATION_GRAVE)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,0)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_SPELL+TYPE_TRAP))
	e3:SetValue(aux.indoval)
	c:RegisterEffect(e3)
	--indes
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
end
