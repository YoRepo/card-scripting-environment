--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 废铁战士  (ID: 42711820)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 3
-- ATK 1700 | DEF 100
-- Setcode: 6684708
--
-- Effect Text:
-- 「废铁同调士」＋调整以外的怪兽1只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡同调召唤的场合才能发动。从卡组选1只「废品同调士」或者1张有「废品战士」的卡名记述的卡加入手卡或送去墓地。
-- ②：「废铁战士」以外的自己场上的以下怪兽发动的效果不会被无效化。
-- ●有「废品战士」的卡名记述的怪兽
-- ●原本卡名包含「战士」的同调怪兽
--[[ __CARD_HEADER_END__ ]]

--スクラップ・ウォリアー
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,60800381,63977008)
	aux.AddMaterialCodeList(c,16449363)
	--synchro summon
	aux.AddSynchroProcedure(c,s.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.thcon)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
	--inactivatable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_DISEFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(s.effectfilter)
	c:RegisterEffect(e2)
end
s.material_setcode=0x1017
function s.tfilter(c)
	return c:IsCode(16449363) or c:IsHasEffect(20932152)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function s.thfilter(c)
	return (c:IsCode(63977008) or aux.IsCodeListed(c,60800381)) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()<=0 then return end
	local tc=g:GetFirst()
	if tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	elseif tc:IsAbleToGrave() then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
function s.effectfilter(e,ct)
	local p=e:GetHandler():GetControler()
	local te,tp,loc=Duel.GetChainInfo(ct,CHAININFO_TRIGGERING_EFFECT,CHAININFO_TRIGGERING_PLAYER,CHAININFO_TRIGGERING_LOCATION)
	local tc=te:GetHandler()
	return p==tp and not tc:IsCode(id) and loc==LOCATION_MZONE and te:IsActiveType(TYPE_MONSTER)
		and (tc:IsOriginalSetCard(0x66) and tc:IsType(TYPE_SYNCHRO) or aux.IsCodeListed(tc,60800381))
end
