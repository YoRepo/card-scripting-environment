--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 冰水帝 钠铬辉石精  (ID: 3355732)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level 10
-- ATK 1500 | DEF 3000
-- Setcode: 364
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：场地区域有表侧表示卡存在的场合，这张卡可以从手卡特殊召唤。
-- ②：只要场上有「冰水底 铬离子少女摇篮」存在，对方不能把除这个回合召唤·反转召唤·特殊召唤的怪兽外的场上的怪兽的效果发动。
-- ③：只在自己的「冰水」怪兽和对方怪兽进行战斗的伤害计算时，那只对方怪兽的攻击力下降1000。
--[[ __CARD_HEADER_END__ ]]

--氷水帝コスモクロア
function c3355732.initial_effect(c)
	aux.AddCodeList(c,7142724)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,3355732+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c3355732.spcon)
	c:RegisterEffect(e1)
	--cannot activate
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_TRIGGER)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetCondition(c3355732.actcon)
	e2:SetTarget(c3355732.actlimit)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c3355732.atkcon)
	e3:SetTarget(c3355732.atktg)
	e3:SetValue(-1000)
	c:RegisterEffect(e3)
end
function c3355732.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
function c3355732.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsEnvironment(7142724)
end
function c3355732.actlimit(e,c)
	return not c:IsStatus(STATUS_SUMMON_TURN+STATUS_FLIP_SUMMON_TURN+STATUS_SPSUMMON_TURN)
end
function c3355732.atkcon(e)
	local tp=e:GetHandlerPlayer()
	local a,d=Duel.GetBattleMonster(tp)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL and a and d and a:IsSetCard(0x16c)
end
function c3355732.atktg(e,c)
	local tp=e:GetHandlerPlayer()
	local a,d=Duel.GetBattleMonster(tp)
	return c==d
end
