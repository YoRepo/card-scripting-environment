--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 宫廷的规矩  (ID: 9995766)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：「宫廷的规矩」在自己场上只能有1张表侧表示存在。
-- ②：只要这张卡在魔法与陷阱区域存在，「宫廷的规矩」以外的双方场上的表侧表示的永续陷阱卡不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--宮廷のしきたり
function c9995766.initial_effect(c)
	c:SetUniqueOnField(1,0,9995766)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e2:SetTarget(c9995766.infilter)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	c:RegisterEffect(e3)
end
function c9995766.infilter(e,c)
	return bit.band(c:GetType(),0x20004)==0x20004 and not c:IsCode(9995766)
end
