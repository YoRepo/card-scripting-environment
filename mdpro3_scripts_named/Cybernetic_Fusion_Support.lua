--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 电子融合支援  (ID: 58199906)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4587668
--
-- Effect Text:
-- 把基本分支付一半才能发动。这个回合，自己把机械族的融合怪兽融合召唤的场合只有1次，可以把那张融合怪兽卡决定的融合素材怪兽从自己的手卡·场上·墓地选出从游戏中除外，用这些作为融合素材。「电子融合支援」在
-- 1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--サイバネティック・フュージョン・サポート
function c58199906.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,58199906+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c58199906.cost)
	e1:SetOperation(c58199906.activate)
	c:RegisterEffect(e1)
end
function c58199906.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
end
function c58199906.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(58199906,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHAIN_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c58199906.chain_target)
	e1:SetOperation(c58199906.chain_operation)
	e1:SetValue(aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE))
	Duel.RegisterEffect(e1,tp)
end
function c58199906.filter(c,e)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeFusionMaterial() and c:IsAbleToRemove() and not c:IsImmuneToEffect(e)
end
function c58199906.chain_target(e,te,tp)
	return Duel.GetMatchingGroup(c58199906.filter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_HAND,0,nil,te)
end
function c58199906.chain_operation(e,te,tp,tc,mat,sumtype)
	if not sumtype then sumtype=SUMMON_TYPE_FUSION end
	tc:SetMaterial(mat)
	Duel.Remove(mat,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
	Duel.BreakEffect()
	Duel.SpecialSummon(tc,sumtype,tp,tp,false,false,POS_FACEUP)
	e:Reset()
end
