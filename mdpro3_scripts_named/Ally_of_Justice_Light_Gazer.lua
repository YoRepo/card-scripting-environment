--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 正义盟军 灯眼怪  (ID: 19204398)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Machine
-- Level 8
-- ATK 2400 | DEF 1600
-- Setcode: 1
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡的攻击力上升对方墓地存在的光属性怪兽数量×200的数值。
--[[ __CARD_HEADER_END__ ]]

--A・O・J ライト・ゲイザー
function c19204398.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c19204398.val)
	c:RegisterEffect(e1)
end
function c19204398.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsAttribute,c:GetControler(),0,LOCATION_GRAVE,nil,ATTRIBUTE_LIGHT)*200
end
