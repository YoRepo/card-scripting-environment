--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 伟人庇护战车骑士  (ID: 34876719)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Aqua
-- Rank 5
-- ATK 1700 | DEF 2700
--
-- Effect Text:
-- 5星怪兽×2
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要场上有「No.」怪兽存在，这张卡不会被战斗破坏。
-- ②：自己·对方的主要阶段，把这张卡2个超量素材取除才能发动。把1只「No.101」～「No.107」其中任意种的「No.」超量怪兽从额外卡组作为这张卡的超量素材。那之后，可以把场上1只其他的表侧表示怪
-- 兽作为这张卡的超量素材。
--[[ __CARD_HEADER_END__ ]]

--N・As・H Knight
function c34876719.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,2)
	c:EnableReviveLimit()
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c34876719.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--overlay
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(34876719,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,34876719)
	e2:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_MAIN_END)
	e2:SetCondition(c34876719.ovcon)
	e2:SetCost(c34876719.ovcost)
	e2:SetTarget(c34876719.ovtg)
	e2:SetOperation(c34876719.ovop)
	c:RegisterEffect(e2)
end
function c34876719.indfilter(c)
	return c:IsSetCard(0x48) and c:IsFaceup()
end
function c34876719.indcon(e)
	return Duel.IsExistingMatchingCard(c34876719.indfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c34876719.ovcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c34876719.ovcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c34876719.ovfilter(c,sc)
	local no=aux.GetXyzNumber(c)
	return no and no>=101 and no<=107 and c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and c:IsCanBeXyzMaterial(sc) and c:IsCanOverlay()
end
function c34876719.ovtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c34876719.ovfilter,tp,LOCATION_EXTRA,0,1,nil,e:GetHandler()) end
end
function c34876719.ovfilter2(c)
	return c:IsFaceup() and c:IsCanOverlay()
end
function c34876719.ovop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local mg=Duel.SelectMatchingCard(tp,c34876719.ovfilter,tp,LOCATION_EXTRA,0,1,1,nil,c)
	if #mg==0 then return end
	Duel.Overlay(c,mg)
	local g=Duel.GetMatchingGroup(c34876719.ovfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,c)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(34876719,1)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local tg=g:Select(tp,1,1,nil)
		Duel.HintSelection(tg)
		local tc=tg:GetFirst()
		if not tc:IsImmuneToEffect(e) then
			local og=tc:GetOverlayGroup()
			if og:GetCount()>0 then
				Duel.SendtoGrave(og,REASON_RULE)
			end
			Duel.Overlay(c,tg)
		end
	end
end
