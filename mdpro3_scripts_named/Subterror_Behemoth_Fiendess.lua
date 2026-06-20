--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 地中族邪界妖魔  (ID: 74937659)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Wyrm
-- ATK 2000 | LINK
-- Setcode: 4333
--
-- Effect Text:
-- 反转怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的攻击力上升作为这张卡的连接素材的「地中族」怪兽的原本等级合计×100。
-- ②：自己主要阶段才能发动。从卡组把1只反转怪兽送去墓地，从手卡把1只怪兽在这张卡所连接区里侧守备表示特殊召唤。
-- ③：1回合1次，这张卡所连接区的怪兽反转的场合发动。从自己的卡组·墓地把1只反转怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--サブテラーマリスの妖魔
function c74937659.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_FLIP),2,2)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATERIAL_CHECK)
	e1:SetValue(c74937659.matcheck)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74937659,0))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,74937659)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c74937659.tgtg)
	e2:SetOperation(c74937659.tgop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(74937659,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_FLIP)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c74937659.thcon)
	e3:SetTarget(c74937659.thtg)
	e3:SetOperation(c74937659.thop)
	c:RegisterEffect(e3)
end
function c74937659.matfilter(c)
	return c:IsSetCard(0xed) and c:GetOriginalLevel()>=0
end
function c74937659.matcheck(e,c)
	local g=c:GetMaterial():Filter(c74937659.matfilter,nil)
	local atk=g:GetSum(Card.GetOriginalLevel)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk*100)
	e1:SetReset(RESET_EVENT+0xff0000)
	c:RegisterEffect(e1)
end
function c74937659.tgfilter(c)
	return c:IsType(TYPE_FLIP) and c:IsAbleToGrave()
end
function c74937659.spfilter(c,e,tp,zone)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN_DEFENSE,tp,zone)
end
function c74937659.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=e:GetHandler():GetLinkedZone(tp)
	if chk==0 then return Duel.IsExistingMatchingCard(c74937659.tgfilter,tp,LOCATION_DECK,0,1,nil)
		and Duel.IsExistingMatchingCard(c74937659.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,zone) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c74937659.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c74937659.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 and Duel.SendtoGrave(g,REASON_EFFECT)~=0
		and g:GetFirst():IsLocation(LOCATION_GRAVE) then
		local zone=e:GetHandler():GetLinkedZone(tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c74937659.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,zone)
		if zone~=0 and sg:GetCount()>0 then
			local hint=sg:GetFirst():IsPublic()
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE,zone)
			if hint then
				Duel.ConfirmCards(1-tp,sg)
			end
		end
	end
end
function c74937659.cfilter(c,ec)
	if c:IsLocation(LOCATION_MZONE) then
		return ec:GetLinkedGroup():IsContains(c)
	else
		return bit.extract(ec:GetLinkedZone(c:GetPreviousControler()),c:GetPreviousSequence())~=0
	end
end
function c74937659.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c74937659.cfilter,1,nil,e:GetHandler())
end
function c74937659.thfilter(c)
	return c:IsType(TYPE_FLIP) and c:IsAbleToHand()
end
function c74937659.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c74937659.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c74937659.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
