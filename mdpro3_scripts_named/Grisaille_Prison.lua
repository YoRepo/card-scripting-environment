--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 纯灰色画的牢狱  (ID: 22888900)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上有上级召唤·仪式召唤·融合召唤的怪兽之内任意种表侧表示存在的场合才能发动。直到下次的对方回合的结束时，双方不能进行同调·超量召唤，场上的同调·超量怪兽效果无效化，不能攻击。
--[[ __CARD_HEADER_END__ ]]

--グリザイユの牢獄
function c22888900.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c22888900.condition)
	e1:SetOperation(c22888900.operation)
	c:RegisterEffect(e1)
end
function c22888900.cfilter(c)
	return c:IsFaceup()
		and (c:IsSummonType(SUMMON_TYPE_ADVANCE) or c:IsSummonType(SUMMON_TYPE_RITUAL) or c:IsSummonType(SUMMON_TYPE_FUSION))
end
function c22888900.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22888900.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c22888900.operation(e,tp,eg,ep,ev,re,r,rp)
	--
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c22888900.tg)
	e1:SetCode(EFFECT_DISABLE)
	if Duel.GetTurnPlayer()~=tp then
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	Duel.RegisterEffect(e2,tp)
	--
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	e3:SetTarget(c22888900.splimit)
	if Duel.GetTurnPlayer()~=tp then
		e3:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e3:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
	end
	Duel.RegisterEffect(e3,tp)
end
function c22888900.tg(e,c)
	return c:IsType(TYPE_SYNCHRO+TYPE_XYZ)
end
function c22888900.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_SYNCHRO)==SUMMON_TYPE_SYNCHRO or bit.band(sumtp,SUMMON_TYPE_XYZ)==SUMMON_TYPE_XYZ
end
