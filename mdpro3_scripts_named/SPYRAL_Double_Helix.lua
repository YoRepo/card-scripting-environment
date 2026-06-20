--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 秘旋谍-双螺旋特工  (ID: 1322368)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- ATK 1900 | LINK
-- Setcode: 238
--
-- Effect Text:
-- 「秘旋谍」怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡的卡名只要在场上·墓地存在当作「秘旋谍-花公子」使用。
-- ②：宣言卡的种类（怪兽·魔法·陷阱）才能发动。对方卡组最上面的卡给双方确认，宣言的种类的卡的场合，从自己的卡组·墓地选1只「秘旋谍」怪兽加入手卡或在作为这张卡所连接区的自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--SPYRAL－ザ・ダブルヘリックス
function c1322368.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xee),2,2)
	--change name
	aux.EnableChangeCode(c,41091257,LOCATION_MZONE+LOCATION_GRAVE)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1322368,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,1322368)
	e2:SetTarget(c1322368.sptg)
	e2:SetOperation(c1322368.spop)
	c:RegisterEffect(e2)
end
function c1322368.spfilter(c,e,tp,zone)
	return c:IsSetCard(0xee) and c:IsType(TYPE_MONSTER) and (c:IsAbleToHand() or (zone~=0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)))
end
function c1322368.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local zone=e:GetHandler():GetLinkedZone()
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0
		and Duel.IsExistingMatchingCard(c1322368.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp,zone) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	e:SetLabel(Duel.AnnounceType(tp))
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c1322368.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)==0 then return end
	Duel.ConfirmDecktop(1-tp,1)
	local g=Duel.GetDecktopGroup(1-tp,1)
	local tc=g:GetFirst()
	local opt=e:GetLabel()
	if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
		local zone=e:GetHandler():GetLinkedZone(tp)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
		local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c1322368.spfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp,zone)
		local sc=sg:GetFirst()
		if sc then
			if zone~=0 and sc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP,tp,zone)
				and (not sc:IsAbleToHand() or Duel.SelectOption(tp,1190,1152)==1) then
				Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP,zone)
			else
				Duel.SendtoHand(sc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sc)
			end
		end
	end
end
