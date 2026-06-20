--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 原石龙 帝王黄玉龙  (ID: 81418467)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dragon
-- Level 6
-- ATK 2600 | DEF 0
-- Setcode: 441
--
-- Effect Text:
-- 这张卡在把1只通常怪兽解放的场合才能召唤。这个卡名的①的效果1回合只能使用1次。
-- ①：对方主要阶段，把手卡的这张卡给对方观看才能发动。进行1只「原石」怪兽的召唤。
-- ②：这张卡上级召唤的场合才能发动。以下效果各适用。
-- ●对方场上的全部表侧表示怪兽的效果无效化。
-- ●种族或属性和自己墓地的通常怪兽的其中任意种相同的对方场上的怪兽全部除外。
--[[ __CARD_HEADER_END__ ]]

--原石竜インペリアル・ドラゴン
local s,id,o=GetID()
function s.initial_effect(c)
	--summon with 1 tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e1:SetCondition(s.ttcon)
	e1:SetOperation(s.ttop)
	e1:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e1)
	--extra summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_HAND)
	e2:SetHintTiming(TIMING_MAIN_END)
	e2:SetCountLimit(1,id)
	e2:SetCondition(s.smcon)
	e2:SetCost(s.smcost)
	e2:SetTarget(s.smtg)
	e2:SetOperation(s.smop)
	c:RegisterEffect(e2)
	--Disable & Remove
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DISABLE+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(s.drcon)
	e3:SetTarget(s.drtg)
	e3:SetOperation(s.drop)
	c:RegisterEffect(e3)
end
function s.tbfilter(c,tp)
	return c:IsType(TYPE_NORMAL) and (c:IsControler(tp) or c:IsFaceup())
end
function s.ttcon(e,c,minc)
	if c==nil then return true end
	local g=Duel.GetMatchingGroup(s.tbfilter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil,c:GetControler())
	return minc<=1 and Duel.CheckTribute(c,1,1,g,c:GetControler())
end
function s.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.GetMatchingGroup(s.tbfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp)
	local tg=Duel.SelectTribute(tp,c,1,1,g)
	c:SetMaterial(tg)
	Duel.Release(tg,REASON_SUMMON+REASON_MATERIAL)
end
function s.smcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function s.smcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function s.sumfilter(c)
	return c:IsSummonable(true,nil) and c:IsSetCard(0x1b9)
end
function s.smtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_SUMMON,nil,1,0,0)
end
function s.smop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SUMMON)
	local g=Duel.SelectMatchingCard(tp,s.sumfilter,tp,LOCATION_HAND+LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.Summon(tp,tc,true,nil)
	end
end
function s.drcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_ADVANCE)
end
function s.rmfilter1(c)
	return c:IsFaceup() and c:IsAbleToRemove()
	and Duel.IsExistingMatchingCard(s.rmfilter2,1-c:GetControler(),LOCATION_GRAVE,0,1,nil,c:GetRace(),c:GetAttribute())
end
function s.rmfilter2(c,race,att)
	return c:IsType(TYPE_NORMAL) and c:IsFaceupEx() and (c:IsRace(race) or c:IsAttribute(att))
end
function s.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,1,nil)
		or Duel.IsExistingMatchingCard(s.rmfilter1,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,nil)
	local g2=Duel.GetMatchingGroup(s.rmfilter1,tp,0,LOCATION_MZONE,nil)
	if #g>0 then Duel.SetOperationInfo(0,CATEGORY_DISABLE,g,g:GetCount(),0,0) end
	if #g2>0 then Duel.SetOperationInfo(0,CATEGORY_REMOVE,g2,g2:GetCount(),0,0) end
end
function s.drop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NegateMonsterFilter,tp,0,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		e2:SetValue(RESET_TURN_SET)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
	Duel.AdjustInstantly()
	Duel.BreakEffect()
	local g2=Duel.GetMatchingGroup(s.rmfilter1,tp,0,LOCATION_MZONE,nil)
	Duel.Remove(g2,POS_FACEUP,REASON_EFFECT)
end
