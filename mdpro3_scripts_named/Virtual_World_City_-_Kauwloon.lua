--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 电脑堺都-九龙  (ID: 14886190)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 334
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组把1张「电脑堺门」卡在自己的魔法与陷阱区域表侧表示放置。那之后，自己场上的「电脑堺门」卡数量的以下效果各能适用。
-- ●2张以上：这个回合，自己场上的「电脑堺」怪兽的攻击力上升200。
-- ●3张以上：从自己卡组上面把3张卡送去墓地。
-- ●4张：从额外卡组把最多4只「电脑堺」怪兽特殊召唤（同名卡最多1张）。
--[[ __CARD_HEADER_END__ ]]

--電脳堺都－九竜
function c14886190.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(14886190,0))
	e1:SetCategory(CATEGORY_DECKDES+CATEGORY_TOGRAVE+CATEGORY_ATKCHANGE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,14886190+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c14886190.target)
	e1:SetOperation(c14886190.activate)
	c:RegisterEffect(e1)
end
function c14886190.tffilter(c,tp)
	return c:IsSetCard(0x114e) and not c:IsType(TYPE_FIELD+TYPE_MONSTER) and not c:IsForbidden() and c:CheckUniqueOnField(tp)
end
function c14886190.gtfilter(c)
	return c:IsSetCard(0x114e) and c:IsFaceup()
end
function c14886190.spfilter(c,e,tp)
	return c:IsSetCard(0x14e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0
end
function c14886190.exfilter1(c)
	return c:IsFacedown() and c:IsType(TYPE_XYZ+TYPE_SYNCHRO+TYPE_FUSION)
end
function c14886190.exfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) or c:IsFacedown() and c:IsType(TYPE_LINK)
end
function c14886190.fselect(g,ft1,ft2,ect,ft)
	return aux.dncheck(g) and #g<=ft and #g<=ect
		and g:FilterCount(c14886190.exfilter1,nil)<=ft1
		and g:FilterCount(c14886190.exfilter2,nil)<=ft2
end
function c14886190.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
		if e:IsHasType(EFFECT_TYPE_ACTIVATE) and not e:GetHandler():IsLocation(LOCATION_SZONE) then ft=ft-1 end
		return ft>0 and Duel.IsExistingMatchingCard(c14886190.tffilter,tp,LOCATION_DECK,0,1,nil,tp)
	end
end
function c14886190.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c14886190.tffilter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		if Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true) then
			local gc=Duel.GetMatchingGroupCount(c14886190.gtfilter,tp,LOCATION_ONFIELD,0,nil)
			if gc>=2 and Duel.SelectYesNo(tp,aux.Stringid(14886190,1)) then
				Duel.BreakEffect()
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_FIELD)
				e1:SetCode(EFFECT_UPDATE_ATTACK)
				e1:SetTargetRange(LOCATION_MZONE,0)
				e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x14e))
				e1:SetValue(200)
				e1:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e1,tp)
			end
			if gc>=3 and Duel.IsPlayerCanDiscardDeck(tp,3) and Duel.SelectYesNo(tp,aux.Stringid(14886190,2)) then
				Duel.BreakEffect()
				Duel.DiscardDeck(tp,3,REASON_EFFECT)
			end
			if gc==4 and Duel.IsExistingMatchingCard(c14886190.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) then
				local ft1=Duel.GetLocationCountFromEx(tp,tp,nil,TYPE_XYZ+TYPE_SYNCHRO+TYPE_FUSION)
				local ft2=Duel.GetLocationCountFromEx(tp,tp,nil,TYPE_PENDULUM+TYPE_LINK)
				local ft=Duel.GetUsableMZoneCount(tp)
				if Duel.IsPlayerAffectedByEffect(tp,59822133) then
					if ft1>0 then ft1=1 end
					if ft2>0 then ft2=1 end
					if ft>0 then ft=1 end
				end
				local ect=(c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]) or ft
				if ect>0 and (ft1>0 or ft2>0) and Duel.SelectYesNo(tp,aux.Stringid(14886190,3)) then
					Duel.BreakEffect()
					local sg=Duel.GetMatchingGroup(c14886190.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
					local rg=sg:SelectSubGroup(tp,c14886190.fselect,false,1,4,ft1,ft2,ect,ft)
					Duel.SpecialSummon(rg,0,tp,tp,false,false,POS_FACEUP)
				end
			end
		end
	end
end
