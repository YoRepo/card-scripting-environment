--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 被检体 秘异三变体M-05  (ID: 62201847)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Psychic
-- Level 2
-- ATK 0 | DEF 500
-- Setcode: 343
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合才能发动。从卡组把「被检体 秘异三变体M-05」以外的1只「秘异三变」怪兽加入手卡。
-- ②：把这张卡解放，把1张手卡或者自己场上的表侧表示的卡除外才能发动。除外的卡种类的1只以下怪兽从手卡·卡组特殊召唤。
-- ●怪兽：「秘异三变猛兽」
-- ●魔法：「秘异三变秘法家」
-- ●陷阱：「秘异三变武装者」
--[[ __CARD_HEADER_END__ ]]

--被検体ミュートリアM－05
function c62201847.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62201847,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,62201847)
	e1:SetTarget(c62201847.thtg)
	e1:SetOperation(c62201847.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(62201847,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,62201848)
	e3:SetCost(c62201847.spcost)
	e3:SetTarget(c62201847.sptg)
	e3:SetOperation(c62201847.spop)
	c:RegisterEffect(e3)
end
function c62201847.thfilter(c)
	return c:IsSetCard(0x157) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand() and not c:IsCode(62201847)
end
function c62201847.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c62201847.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c62201847.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c62201847.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c62201847.spcostexcheckfilter(c,e,tp,code)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsCode(code)
end
function c62201847.spcostexcheck(c,e,tp)
	local result=false
	if c:GetOriginalType()&TYPE_MONSTER~=0 then
		result=result or Duel.IsExistingMatchingCard(c62201847.spcostexcheckfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,c,e,tp,34695290)
	end
	if c:GetOriginalType()&TYPE_SPELL~=0 then
		result=result or Duel.IsExistingMatchingCard(c62201847.spcostexcheckfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,c,e,tp,61089209)
	end
	if c:GetOriginalType()&TYPE_TRAP~=0 then
		result=result or Duel.IsExistingMatchingCard(c62201847.spcostexcheckfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,c,e,tp,7574904)
	end
	return result
end
function c62201847.spcostfilter(c,e,tp,tc)
	local tg=Group.FromCards(c,tc)
	return c:IsAbleToRemoveAsCost() and c62201847.spcostexcheck(c,e,tp)
		and (c:IsLocation(LOCATION_HAND) or c:IsFaceup())
		and Duel.GetMZoneCount(tp,tg)>0
end
function c62201847.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		e:SetLabel(100)
		return Duel.IsExistingMatchingCard(c62201847.spcostfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler(),e,tp,e:GetHandler())
			and e:GetHandler():IsReleasable()
	end
	Duel.Release(e:GetHandler(),REASON_COST)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local cost=Duel.SelectMatchingCard(tp,c62201847.spcostfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,e:GetHandler(),e,tp,e:GetHandler()):GetFirst()
	e:SetLabel(cost:GetOriginalType())
	Duel.Remove(cost,POS_FACEUP,REASON_COST)
end
function c62201847.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=100 then return false end
		e:SetLabel(0)
		return true
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c62201847.spopfilter(c,e,tp,typ)
	return (((typ&TYPE_MONSTER)>0 and c:IsCode(34695290))
		or ((typ&TYPE_SPELL)>0 and c:IsCode(61089209))
		or ((typ&TYPE_TRAP)>0 and c:IsCode(7574904)))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c62201847.spop(e,tp,eg,ep,ev,re,r,rp)
	local typ=e:GetLabel()
	if Duel.GetMZoneCount(tp)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c62201847.spopfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp,typ)
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
