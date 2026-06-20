--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 白骨梦魇  (ID: 22339232)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 1
-- ATK 300 | DEF 200
--
-- Effect Text:
-- 这张卡的卡名只要在墓地存在当作「白骨」使用。此外，可以把这张卡从手卡丢弃从以下效果选择1个发动。
-- ●选择从游戏中除外的1只自己的「白骨」或者「白骨梦魇」回到自己墓地。
-- ●选择从游戏中除外的1只自己的「白骨夫人」或者「白骨王」在场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ワイトメア
function c22339232.initial_effect(c)
	--change code
	aux.EnableChangeCode(c,32274490,LOCATION_GRAVE)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCost(c22339232.cost)
	e2:SetTarget(c22339232.tgtg)
	e2:SetOperation(c22339232.tgop)
	c:RegisterEffect(e2)
end
function c22339232.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c22339232.tgfilter(c)
	return c:IsFaceup() and c:IsCode(32274490,22339232)
end
function c22339232.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsCode(36021814,40991587) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c22339232.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then
		if e:GetLabel()==0 then
			return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c22339232.tgfilter(chkc)
		else
			return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c22339232.spfilter(chkc,e,tp)
		end
	end
	local b1=Duel.IsExistingTarget(c22339232.tgfilter,tp,LOCATION_REMOVED,0,1,nil)
	local b2=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c22339232.spfilter,tp,LOCATION_REMOVED,0,1,nil,e,tp)
	if chk==0 then return b1 or b2 end
	local op=0
	if b1 and b2 then
		op=Duel.SelectOption(tp,aux.Stringid(22339232,0),aux.Stringid(22339232,1))
	elseif b1 then
		op=Duel.SelectOption(tp,aux.Stringid(22339232,0))
	else
		op=Duel.SelectOption(tp,aux.Stringid(22339232,1))+1
	end
	e:SetLabel(op)
	if op==0 then
		e:SetCategory(CATEGORY_TOGRAVE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectTarget(tp,c22339232.tgfilter,tp,LOCATION_REMOVED,0,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	else
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectTarget(tp,c22339232.spfilter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	end
end
function c22339232.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetLabel()==0 then
		if tc:IsRelateToEffect(e) then
			Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
		end
	else
		if tc:IsRelateToEffect(e) then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
