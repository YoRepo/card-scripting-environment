--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 阳炎兽 斯芬克司  (ID: 1409474)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 6
-- ATK 1900 | DEF 1900
-- Setcode: 4221
--
-- Effect Text:
-- 只要这张卡在场上表侧表示存在，对方不能把这张卡作为卡的效果的对象。此外，自己的主要阶段时，宣言卡的种类（怪兽·魔法·陷阱）才能发动。自己卡组最上面的卡送去墓地，宣言的种类的卡的场合，可以再从自己的手卡
-- ·墓地选1只炎属性怪兽特殊召唤。「阳炎兽 斯芬克司」的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--陽炎獣 スピンクス
function c1409474.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	--guess
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(1409474,0))
	e2:SetCategory(CATEGORY_DECKDES+CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1,1409474)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c1409474.target)
	e2:SetOperation(c1409474.operation)
	c:RegisterEffect(e2)
end
function c1409474.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	Duel.SetTargetParam(Duel.AnnounceType(tp))
end
function c1409474.spfilter(c,e,tp)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c1409474.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	if not tc then return end
	local opt=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(c1409474.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,nil,e,tp)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(1409474,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
