--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 神灵剑 艾华斯  (ID: 63926180)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：可以从以下效果选择1个发动。这个回合，自己不用融合怪兽不能攻击宣言。
-- ●从自己的卡组·墓地把1只「法之神灵 艾华斯」特殊召唤。
-- ●从卡组选1只「阿莱斯特」怪兽送去墓地或除外。
-- ●把对方的额外卡组的里侧的卡随机3张确认，选那之内的1张除外。
--[[ __CARD_HEADER_END__ ]]

--神霊剣アイワス
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,84288367)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.spfilter(c,e,tp)
	return c:IsCode(84288367) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.tgfilter(c)
	return c:IsSetCard(0x1e1) and c:IsType(TYPE_MONSTER) and (c:IsAbleToGrave() or c:IsAbleToRemove())
end
function s.rmfilter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp)
	local b2=Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil)
	local b3=Duel.IsExistingMatchingCard(s.rmfilter,tp,0,LOCATION_EXTRA,3,nil)
	if chk==0 then return b1 or b2 or b3 end
	local op=aux.SelectFromOptions(tp,
			{b1,aux.Stringid(id,1),1},
			{b2,aux.Stringid(id,2),2},
			{b3,aux.Stringid(id,3),3})
	e:SetLabel(op)
	if op==1 then
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		end
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
	elseif op==2 then
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_TOGRAVE+CATEGORY_REMOVE+CATEGORY_DECKDES)
		end
	elseif op==3 then
		if e:IsCostChecked() then
			e:SetCategory(CATEGORY_REMOVE)
		end
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,1-tp,LOCATION_EXTRA)
	end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(s.atktg)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if e:GetLabel()==1 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	elseif e:GetLabel()==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
		local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			local tc=g:GetFirst()
			if tc and tc:IsAbleToGrave() and (not tc:IsAbleToRemove() or Duel.SelectOption(tp,1191,1192)==0) then
				Duel.SendtoGrave(tc,REASON_EFFECT)
			else
				Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
			end
		end
	elseif e:GetLabel()==3 then
		local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_EXTRA,nil)
		if g:GetCount()<3 then return end
		local cg=g:RandomSelect(1-tp,3)
		local flag=cg:FilterCount(Card.IsAbleToRemove,nil)>0
		Duel.ConfirmCards(tp,cg,flag)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=cg:FilterSelect(tp,Card.IsAbleToRemove,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		Duel.ShuffleExtra(1-tp)
	end
end
function s.atktg(e,c)
	return not c:IsType(TYPE_FUSION)
end
