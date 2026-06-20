--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 召唤兽 普尔加托里奥  (ID: 12307878)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Fiend
-- Level 7
-- ATK 2300 | DEF 2000
-- Setcode: 244
--
-- Effect Text:
-- 「召唤师 阿莱斯特」＋炎属性怪兽
-- ①：这张卡的攻击力上升对方场上的卡数量×200。
-- ②：这张卡可以向对方怪兽全部各作1次攻击，向守备表示怪兽攻击的场合，给与攻击力超过那个守备力的数值的战斗伤害。
--[[ __CARD_HEADER_END__ ]]

--召喚獣プルガトリオ
function c12307878.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,86120751,aux.FilterBoolFunction(Card.IsFusionAttribute,ATTRIBUTE_FIRE),1,true,true)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c12307878.atkval)
	c:RegisterEffect(e1)
	--attack all
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_ATTACK_ALL)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c12307878.atkval(e,c)
	return Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_ONFIELD)*200
end
