--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 超重魔兽 九尾-B  (ID: 85528209)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Machine
-- Level 9
-- ATK 1900 | DEF 2500
-- Setcode: 154
--
-- Effect Text:
-- 调整＋调整以外的「超重武者」怪兽1只以上
-- 这张卡在规则上也当作「超重武者」卡使用。
-- ①：这张卡可以用表侧守备表示的状态作出攻击。那个场合，这张卡用守备力当作攻击力使用进行伤害计算。
-- ②：自己墓地没有魔法·陷阱卡存在的场合，这张卡的守备力上升对方场上的特殊召唤的怪兽数量×900。
--[[ __CARD_HEADER_END__ ]]

--超重魔獣キュウ－B
function c85528209.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x9a),1)
	c:EnableReviveLimit()
	--defense attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DEFENSE_ATTACK)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c85528209.sccon)
	e3:SetValue(c85528209.adval)
	c:RegisterEffect(e3)
end
function c85528209.sccon(e)
	return not Duel.IsExistingMatchingCard(Card.IsType,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil,TYPE_SPELL+TYPE_TRAP)
end
function c85528209.adval(e,c)
	return Duel.GetMatchingGroupCount(c85528209.ctfilter,c:GetControler(),0,LOCATION_MZONE,nil)*900
end
function c85528209.ctfilter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
