--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 女神诗蔻蒂的托宣  (ID: 38576155)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，自己场上的怪兽只有「女武神」怪兽的场合，可以从卡组把1张「女神薇儿丹蒂的引导」加入手卡。
-- ②：1回合1次，自己主要阶段才能发动。从对方卡组上面把3张卡确认，用喜欢的顺序回到卡组上面。这个效果的发动后，直到回合结束时自己不是天使族怪兽不能召唤·特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--女神スクルドの託宣
function c38576155.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,38576155+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c38576155.activate)
	c:RegisterEffect(e1)
	--rearrange
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c38576155.target)
	e2:SetOperation(c38576155.operation)
	c:RegisterEffect(e2)
end
function c38576155.thcfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x122)
end
function c38576155.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and not Duel.IsExistingMatchingCard(c38576155.thcfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c38576155.thfilter(c)
	return c:IsCode(64961254) and c:IsAbleToHand()
end
function c38576155.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c38576155.thfilter,tp,LOCATION_DECK,0,nil)
	if #g>0 and c38576155.thcon(e,tp,eg,ep,ev,re,r,rp) and
		Duel.SelectYesNo(tp,aux.Stringid(38576155,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c38576155.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>2 end
end
function c38576155.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.SortDecktop(tp,1-tp,3)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c38576155.sumlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c38576155.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return not c:IsRace(RACE_FAIRY)
end
