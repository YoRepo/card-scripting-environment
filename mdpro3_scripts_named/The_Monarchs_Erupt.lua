--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 帝王的熔击  (ID: 48716527)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 190
--
-- Effect Text:
-- 自己的额外卡组没有卡存在，自己场上有上级召唤的怪兽存在的场合才能把这张卡发动。
-- ①：只要这张卡在魔法与陷阱区域存在，上级召唤的怪兽以外的场上的表侧表示怪兽的效果无效化。
-- ②：自己结束阶段，上级召唤的怪兽不在自己场上存在的场合这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--帝王の溶撃
function c48716527.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c48716527.actcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c48716527.distg)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_SELF_TOGRAVE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c48716527.tgcon)
	c:RegisterEffect(e3)
end
function c48716527.cfilter(c)
	return c:IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c48716527.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_EXTRA,0)==0
		and Duel.IsExistingMatchingCard(c48716527.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c48716527.distg(e,c)
	return not c:IsSummonType(SUMMON_TYPE_ADVANCE)
end
function c48716527.tgcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_END
		and not Duel.IsExistingMatchingCard(c48716527.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
