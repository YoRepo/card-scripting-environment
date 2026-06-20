--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 古代妖精龙  (ID: 25862681)
-- Type: Monster / Effect / Synchro
-- Attribute: LIGHT
-- Race: Dragon
-- Level 7
-- ATK 2100 | DEF 3000
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。从手卡把1只4星以下的怪兽特殊召唤。这个效果发动的回合，自己不能进行战斗阶段。
-- ②：自己主要阶段才能发动。场地区域的卡全部破坏，自己回复1000基本分。那之后，可以把和破坏的卡卡名不同的1张场地魔法卡从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--エンシェント・フェアリー・ドラゴン
function c25862681.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25862681,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,25862681)
	e1:SetCondition(c25862681.sumcon)
	e1:SetCost(c25862681.cost)
	e1:SetTarget(c25862681.sumtg)
	e1:SetOperation(c25862681.sumop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25862681,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_RECOVER+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,25862682)
	e2:SetCost(c25862681.cost)
	e2:SetTarget(c25862681.destg)
	e2:SetOperation(c25862681.desop)
	c:RegisterEffect(e2)
end
function c25862681.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
end
function c25862681.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c25862681.sumfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c25862681.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c25862681.sumfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_HAND)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c25862681.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c25862681.sumfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c25862681.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_FZONE,LOCATION_FZONE)
	if chk==0 then return g:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c25862681.ffilter(c,g)
	return c:IsType(TYPE_FIELD) and c:IsAbleToHand() and not g:IsExists(Card.IsCode,1,nil,c:GetCode())
end
function c25862681.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_FZONE,LOCATION_FZONE)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
		local og=Duel.GetOperatedGroup()
		if og:GetCount()>0 then
			Duel.Recover(tp,1000,REASON_EFFECT)
			local fg=Duel.GetMatchingGroup(c25862681.ffilter,tp,LOCATION_DECK,0,nil,og)
			if fg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(25862681,2)) then
				Duel.BreakEffect()
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
				local sg=fg:Select(tp,1,1,nil)
				Duel.SendtoHand(sg,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sg)
			end
		end
	end
end
