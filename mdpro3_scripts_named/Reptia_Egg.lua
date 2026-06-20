--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 爬虫蛋  (ID: 81782101)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Reptile
-- Level 1
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡不会被战斗破坏。
-- ②：这张卡召唤成功的场合，下次的自己回合的准备阶段，把这张卡解放才能发动。从手卡·卡组把最多3只4星以下的爬虫类族·岩石族怪兽特殊召唤（2只以上特殊召唤的场合必须全部是同名怪兽）。这个效果特殊召唤的怪
-- 兽在结束阶段除外。
--[[ __CARD_HEADER_END__ ]]

--レプティア・エッグ
function c81782101.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetOperation(c81782101.regop)
	c:RegisterEffect(e2)
end
function c81782101.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81782101,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81782101)
	e1:SetCondition(c81782101.spcon)
	e1:SetCost(c81782101.spcost)
	e1:SetTarget(c81782101.sptg)
	e1:SetOperation(c81782101.spop)
	e1:SetLabel(Duel.GetTurnCount())
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
	end
	c:RegisterEffect(e1)
end
function c81782101.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetTurnCount()~=e:GetLabel()
end
function c81782101.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c81782101.filter(c,e,tp)
	return c:IsRace(RACE_REPTILE+RACE_ROCK) and c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81782101.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>0
		and Duel.IsExistingMatchingCard(c81782101.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c81782101.spcheck(g)
	return g:GetClassCount(Card.GetCode)==1
end
function c81782101.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft>3 then ft=3 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local g=Duel.GetMatchingGroup(c81782101.filter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local hg=g:SelectSubGroup(tp,c81782101.spcheck,false,1,ft)
		local fid=e:GetHandler():GetFieldID()
		local tc=hg:GetFirst()
		while tc do
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(81782101,RESET_EVENT+RESETS_STANDARD,0,1,fid)
			tc=hg:GetNext()
		end
		Duel.SpecialSummonComplete()
		hg:KeepAlive()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetCountLimit(1)
		e1:SetLabel(fid)
		e1:SetLabelObject(hg)
		e1:SetCondition(c81782101.rmcon)
		e1:SetOperation(c81782101.rmop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c81782101.rmfilter(c,fid)
	return c:GetFlagEffectLabel(81782101)==fid
end
function c81782101.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c81782101.rmfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c81782101.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c81782101.rmfilter,nil,e:GetLabel())
	Duel.Remove(tg,POS_FACEUP,REASON_EFFECT)
end
