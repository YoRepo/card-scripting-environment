--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 魔导书的神判  (ID: 46448938)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 4206
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这张卡发动的回合的结束阶段，把最多有这张卡的发动后自己或者对方发动的魔法卡数量的「魔导书的神判」以外的「魔导书」魔法卡从卡组加入手卡。那之后，可以把持有这个效果加入手卡的卡数量以下的等级的1只魔法
-- 师族怪兽从卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔導書の神判
function c46448938.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,46448938+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c46448938.target)
	e1:SetOperation(c46448938.activate)
	c:RegisterEffect(e1)
end
function c46448938.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c46448938.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c46448938.regcon)
	e1:SetOperation(c46448938.regop1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_NEGATED)
	e2:SetCondition(c46448938.regcon)
	e2:SetOperation(c46448938.regop2)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c46448938.effcon)
	e3:SetOperation(c46448938.effop)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
	e1:SetLabelObject(e3)
	e2:SetLabelObject(e3)
end
function c46448938.regcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
function c46448938.regop1(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	e:GetLabelObject():SetLabel(ct+1)
end
function c46448938.regop2(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabelObject():GetLabel()
	if ct==0 then ct=1 end
	e:GetLabelObject():SetLabel(ct-1)
end
function c46448938.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()>0
end
function c46448938.sfilter(c)
	return c:IsSetCard(0x106e) and not c:IsCode(46448938) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c46448938.spfilter(c,lv,e,tp)
	return c:IsLevelBelow(lv) and c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c46448938.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,46448938)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c46448938.sfilter,tp,LOCATION_DECK,0,1,e:GetLabel(),nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and Duel.IsExistingMatchingCard(c46448938.spfilter,tp,LOCATION_DECK,0,1,nil,g:GetCount(),e,tp)
			and Duel.SelectYesNo(tp,aux.Stringid(46448938,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=Duel.SelectMatchingCard(tp,c46448938.spfilter,tp,LOCATION_DECK,0,1,1,nil,g:GetCount(),e,tp)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
