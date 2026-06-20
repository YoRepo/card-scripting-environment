--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 朱罗纪巨兽龙  (ID: 80032567)
-- Type: Monster / Effect / Synchro
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 7
-- ATK 2100 | DEF 1800
-- Setcode: 34
--
-- Effect Text:
-- 调整＋调整以外的恐龙族怪兽1只以上
-- ①：只要这张卡在怪兽区域存在，自己场上的「朱罗纪」怪兽的攻击力上升自己墓地的「朱罗纪」怪兽数量×200。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・ギガノト
function c80032567.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_DINOSAUR),1)
	c:EnableReviveLimit()
	--Atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x22))
	e1:SetValue(c80032567.val)
	c:RegisterEffect(e1)
end
function c80032567.filter(c)
	return c:IsSetCard(0x22) and c:IsType(TYPE_MONSTER)
end
function c80032567.val(e,c)
	return Duel.GetMatchingGroupCount(c80032567.filter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,nil)*200
end
