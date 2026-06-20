--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 炎上框架管理员  (ID: 49847524)
-- Type: Monster / Effect / Link
-- Attribute: FIRE
-- Race: Cyberse
-- ATK 1200 | LINK
--
-- Effect Text:
-- 电子界族怪兽2只
-- ①：「炎上框架管理员」在自己场上只能有1只表侧表示存在。
-- ②：只要这张卡在怪兽区域存在，自己场上的连接怪兽的攻击力上升800。
--[[ __CARD_HEADER_END__ ]]

--フレイム・アドミニスター
function c49847524.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,49847524)
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_CYBERSE),2,2)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsType,TYPE_LINK))
	e1:SetValue(800)
	c:RegisterEffect(e1)
end
