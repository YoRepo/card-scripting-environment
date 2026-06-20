--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 英豪挑战者 伏击兵  (ID: 92609670)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 4207
--
-- Effect Text:
-- 自己的准备阶段时，把场上的这张卡解放才能发动。可以从自己的手卡·墓地选「英豪挑战者 伏击兵」以外的最多2只名字带有「英豪挑战者」的怪兽特殊召唤。「英豪挑战者
-- 伏击兵」的这个效果1回合只能使用1次。这个效果特殊召唤成功时，可以通过把墓地的这张卡从游戏中除外，自己场上的全部名字带有「英豪挑战者」的怪兽的等级变成1星。
--[[ __CARD_HEADER_END__ ]]

--H・C アンブッシュ・ソルジャー
function c92609670.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92609670,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,92609670)
	e1:SetCondition(c92609670.spcon)
	e1:SetCost(c92609670.spcost)
	e1:SetTarget(c92609670.sptg)
	e1:SetOperation(c92609670.spop)
	c:RegisterEffect(e1)
	--lvchange
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92609670,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CUSTOM+92609670)
	e2:SetCost(c92609670.lvcost)
	e2:SetTarget(c92609670.lvtg)
	e2:SetOperation(c92609670.lvop)
	c:RegisterEffect(e2)
end
function c92609670.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c92609670.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c92609670.filter(c,e,tp)
	return not c:IsCode(92609670) and c:IsSetCard(0x106f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c92609670.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c92609670.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c92609670.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=math.min((Duel.GetLocationCount(tp,LOCATION_MZONE)),2)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c92609670.filter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,ft,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+92609670,e,0,tp,tp,0)
	end
end
function c92609670.lvcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsAbleToRemove() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c92609670.lvfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x106f) and c:IsLevelAbove(2)
end
function c92609670.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c92609670.lvfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c92609670.lvop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c92609670.lvfilter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
