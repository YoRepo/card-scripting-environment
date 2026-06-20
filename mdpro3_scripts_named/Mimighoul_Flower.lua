--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 迷拟宝箱鬼·食人花  (ID: 82933935)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Plant
-- Level 1
-- ATK 0 | DEF 2100
-- Setcode: 439
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己主要阶段才能发动。这张卡从手卡往对方场上里侧守备表示特殊召唤。场上有里侧表示怪兽存在的场合，也能作为代替在自己场上表侧表示特殊召唤。
-- ②：这张卡在主要阶段反转的场合发动。以下效果各适用。
-- ●对方可以从自身卡组把1只反转怪兽或1张「迷拟宝箱鬼」卡加入手卡。
-- ●这张卡的控制权移给对方。
--[[ __CARD_HEADER_END__ ]]

--ミミグル・フラワー
local s,id,o=GetID()
function s.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,id)
	e1:SetCondition(aux.MimighoulFlipCondition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,id+o)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function s.thfilter(c)
	return (c:IsSetCard(0x1b7) or c:IsType(TYPE_FLIP)) and c:IsAbleToHand()
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.thfilter,tp,0,LOCATION_DECK,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(id,4)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(tp,sg)
	end
	local c=e:GetHandler()
	if c:IsRelateToChain() then
		Duel.BreakEffect()
		Duel.GetControl(c,1-tp)
	end
end
function s.sspfilter(c,tp,e)
	return Duel.IsExistingMatchingCard(Card.IsFacedown,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function s.ospfilter(c,tp,e)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE,1-tp)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return s.sspfilter(c,tp,e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		or s.ospfilter(c,tp,e) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToChain() or (not s.sspfilter(c,tp,e) and not s.ospfilter(c,tp,e)) then return end
	local b1=s.sspfilter(c,tp,e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	local b2=s.ospfilter(c,tp,e) and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
	local toplayer=aux.SelectFromOptions(tp,
		{b1,aux.Stringid(id,2),tp},
		{b2,aux.Stringid(id,3),1-tp})
	if toplayer==tp then
		Duel.SpecialSummon(c,0,tp,toplayer,false,false,POS_FACEUP)
	elseif toplayer==1-tp then
		Duel.SpecialSummon(c,0,tp,1-tp,false,false,POS_FACEDOWN_DEFENSE)
		Duel.ConfirmCards(tp,c)
	else
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0 then
			Duel.SendtoGrave(c,REASON_RULE)
		end
	end
end
