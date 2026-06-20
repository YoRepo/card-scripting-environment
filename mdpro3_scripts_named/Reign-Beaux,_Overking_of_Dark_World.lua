--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 暗黑界的魔神王 雷恩  (ID: 41406613)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- ATK 3000 | DEF 1800
-- Setcode: 6
--
-- Effect Text:
-- ①：这张卡可以让自己场上1只7星以下的「暗黑界」怪兽回到持有者手卡，从墓地特殊召唤。
-- ②：这张卡被效果从手卡丢弃去墓地的场合才能发动。从卡组把「暗黑界的魔神王 雷恩」以外的1只5星以上的「暗黑界」怪兽加入手卡。被对方的效果丢弃的场合，可以再从自己的卡组·墓地选1只4星以下的「暗黑界」怪
-- 兽在自己或者对方场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--暗黒界の魔神王 レイン
function c41406613.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41406613,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c41406613.spcon)
	e1:SetTarget(c41406613.sptg)
	e1:SetOperation(c41406613.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41406613,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c41406613.condition)
	e2:SetTarget(c41406613.target)
	e2:SetOperation(c41406613.operation)
	c:RegisterEffect(e2)
end
function c41406613.spfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x6) and c:IsLevelBelow(7) and c:IsAbleToHandAsCost()
		and Duel.GetMZoneCount(tp,c)>0
end
function c41406613.spcon(e,c)
	if c==nil then return true end
	if c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	local tp=c:GetControler()
	return Duel.IsExistingMatchingCard(c41406613.spfilter,tp,LOCATION_MZONE,0,1,nil,tp)
end
function c41406613.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c41406613.spfilter,tp,LOCATION_MZONE,0,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c41406613.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.SendtoHand(g,nil,REASON_SPSUMMON)
end
function c41406613.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	e:SetLabel(c:GetPreviousControler())
	return c:IsPreviousLocation(LOCATION_HAND) and (r&(REASON_EFFECT+REASON_DISCARD))==REASON_EFFECT+REASON_DISCARD
end
function c41406613.filter1(c)
	return c:IsSetCard(0x6) and c:IsAbleToHand() and c:IsLevelAbove(5) and not c:IsCode(41406613)
end
function c41406613.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41406613.filter1,tp,LOCATION_DECK,0,1,nil) end
	if rp==1-tp and tp==e:GetLabel() then
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	else
		e:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c41406613.filter2(c,e,tp,ft,ft2)
	return c:IsSetCard(0x6) and c:IsLevelBelow(4)
		and ((ft>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP))
			or (ft2>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)))
end
function c41406613.operation(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetMZoneCount(tp)
	local ft2=Duel.GetMZoneCount(1-tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c41406613.filter1,tp,LOCATION_DECK,0,1,1,nil)
	if #g>0 and Duel.SendtoHand(g,nil,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,g)
		if rp==1-tp and tp==e:GetLabel()
			and Duel.IsExistingMatchingCard(aux.NecroValleyFilter(c41406613.filter2),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,ft,ft2)
			and Duel.SelectYesNo(tp,aux.Stringid(41406613,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local tg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c41406613.filter2),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp,ft,ft2)
			Duel.BreakEffect()
			local tc=tg:GetFirst()
			local o1=ft>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
			local o2=ft2>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,1-tp)
			local opt=0
			if o1 and o2 then
				opt=Duel.SelectOption(tp,aux.Stringid(41406613,3),aux.Stringid(41406613,4))
			elseif o1 then
				opt=0
			else
				opt=1
			end
			local p=tp
			if opt==1 then p=1-tp end
			Duel.SpecialSummon(tc,0,tp,p,false,false,POS_FACEUP)
		end
	end
end
