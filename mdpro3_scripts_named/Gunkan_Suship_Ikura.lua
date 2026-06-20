--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 鲑鱼子军贯  (ID: 61027400)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Aqua
-- Level 4
-- ATK 200 | DEF 300
-- Setcode: 358
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有「舍利军贯」存在的场合，这张卡可以从手卡特殊召唤。
-- ②：自己主要阶段才能发动。从自己卡组上面把3张卡翻开。可以从那之中选1只「舍利军贯」加入手卡或特殊召唤。剩下的卡回到卡组。
--[[ __CARD_HEADER_END__ ]]

--いくらの軍貫
function c61027400.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,61027400+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c61027400.sprcon)
	c:RegisterEffect(e1)
	--to hand or special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61027400,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,61027401)
	e2:SetTarget(c61027400.target)
	e2:SetOperation(c61027400.operation)
	c:RegisterEffect(e2)
end
function c61027400.sprfilter(c)
	return c:IsFaceup() and c:IsCode(24639891)
end
function c61027400.sprcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c61027400.sprfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c61027400.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetDecktopGroup(tp,3)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=3
		and (g:IsExists(Card.IsAbleToHand,1,nil) or ft>0
		and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,63060238) and not Duel.IsPlayerAffectedByEffect(tp,97148796)) end
end
function c61027400.filter(c,e,tp,ft)
	return c:IsCode(24639891) and (c:IsAbleToHand() or ft>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false))
end
function c61027400.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,3)
	if #g==3 then
		Duel.ConfirmDecktop(tp,3)
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		local tg=g:Filter(c61027400.filter,nil,e,tp,ft)
		if #tg>0 and Duel.SelectYesNo(tp,aux.Stringid(61027400,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
			local sg=tg:Select(tp,1,1,nil)
			local tc=sg:GetFirst()
			if tc:IsAbleToHand() and (ft<=0 or not tc:IsCanBeSpecialSummoned(e,0,tp,false,false) or Duel.SelectOption(tp,1190,1152)==0) then
				Duel.SendtoHand(tc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,tc)
			else
				Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
			end
		end
		Duel.ShuffleDeck(tp)
	end
end
