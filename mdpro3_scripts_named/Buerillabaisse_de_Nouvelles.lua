--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 新式魔厨的马赛鱼汤布耶尔  (ID: 26223582)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 1
-- ATK 400 | DEF 1850
-- Setcode: 406
--
-- Effect Text:
-- 「食谱」卡降临。这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡特殊召唤成功的场合才能发动。从自己卡组上面把5张卡翻开。可以从那之中选1张「新式魔厨」卡加入手卡。剩余回到卡组。
-- ②：场上的这张卡成为攻击·效果的对象时才能发动。这张卡和自己·对方场上1只攻击表示怪兽解放，从手卡·卡组把1只2·3星的「新式魔厨」仪式怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ブエリヤベース・ド・ヌーベルズ
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon success
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--be target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_RELEASE+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_BECOME_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,id+o)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	c:RegisterEffect(e3)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=5 end
	Duel.SetTargetPlayer(tp)
end
function s.thfilter(c)
	return c:IsSetCard(0x196) and c:IsAbleToHand()
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.ConfirmDecktop(p,5)
	local g=Duel.GetDecktopGroup(p,5)
	local tg=g:Filter(s.thfilter,nil)
	if #tg>0 and Duel.SelectYesNo(p,aux.Stringid(id,2)) then
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_ATOHAND)
		local sg=tg:Select(p,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-p,sg)
	end
	Duel.ShuffleDeck(p)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function s.relfilter(c,tp,ec)
	return c:IsReleasableByEffect() and c:IsAttackPos()
		and Duel.GetMZoneCount(tp,Group.FromCards(c,ec))>0
end
function s.spfilter(c,e,tp)
	return c:IsSetCard(0x196) and c:IsLevel(2,3) and c:GetType()&0x81==0x81
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasableByEffect()
		and Duel.IsExistingMatchingCard(s.relfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,tp,c)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,s.relfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,c,tp,c)
	if g:GetCount()==0 then return end
	g:AddCard(c)
	if Duel.Release(g,REASON_EFFECT)~=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp):GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
	end
end
