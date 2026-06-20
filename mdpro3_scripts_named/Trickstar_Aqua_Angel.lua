--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 淘气仙星·阿库阿安琪儿  (ID: 37405032)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fairy
-- Level 4
-- ATK 0 | DEF 0
-- Setcode: 19595515
--
-- Effect Text:
-- 这个卡名在规则上也当作「海晶少女」卡使用。这个卡名的①③的效果在决斗中各能使用1次。
-- ①：自己场上有「淘气仙星」怪兽或「海晶少女」怪兽存在的场合才能发动。这张卡从手卡·墓地特殊召唤。
-- ②：有这张卡位于所连接区的连接怪兽不会被战斗破坏。
-- ③：这张卡作为连接素材送去墓地的场合才能发动。对方的手卡·场上（里侧表示）的卡全部确认。
--[[ __CARD_HEADER_END__ ]]

--トリックスター・アクアエンジェル
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_DUEL)
	e1:SetCondition(s.spcon)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetTarget(s.latktg)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetCountLimit(1,id+o+EFFECT_COUNT_CODE_DUEL)
	e3:SetCondition(s.cfcon)
	e3:SetTarget(s.cftg)
	e3:SetOperation(s.cfop)
	c:RegisterEffect(e3)
end
function s.cfilter(c)
	return c:IsSetCard(0xfb,0x12b) and c:IsFaceup()
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function s.latktg(e,c)
	return c:IsType(TYPE_LINK) and c:GetLinkedGroup():IsContains(e:GetHandler())
end
function s.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_LINK and e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function s.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.NOT(Card.IsPublic),tp,0,LOCATION_HAND,1,nil) or Duel.IsExistingMatchingCard(Card.IsFacedown,tp,0,LOCATION_ONFIELD,1,nil) end
end
function s.cffilter(c)
	return c:IsLocation(LOCATION_HAND) or c:IsFacedown()
end
function s.cfop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_ONFIELD+LOCATION_HAND)
	if g:GetCount()>0 then
		local cg=g:Filter(s.cffilter,nil)
		Duel.ConfirmCards(tp,cg)
		Duel.ShuffleHand(1-tp)
	end
end
