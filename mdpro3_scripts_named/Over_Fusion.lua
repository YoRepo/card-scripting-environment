--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 融合超涡  (ID: 52553471)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以场上1只表侧表示怪兽为对象才能发动。从手卡·卡组·额外卡组选「元素英雄」怪兽、「新空间侠」怪兽、10星怪兽之内1只给对方观看。这个回合，把作为对象的怪兽作为融合素材的场合，可以当作给人观看的怪兽
-- 的同名卡使用。自己的场上或者墓地有「元素英雄 新宇侠」存在的场合，给人观看的怪兽送去墓地。那以外的场合，从手卡给人观看的怪兽回到卡组。
--[[ __CARD_HEADER_END__ ]]

--融合超渦
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,89943723)
	aux.AddSetNameMonsterList(c,0x3008)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TODECK+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.fstg)
	e1:SetOperation(s.fsop)
	c:RegisterEffect(e1)
end
function s.tgfilter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(s.cfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_EXTRA,0,1,nil,c,tp)
end
function s.cfilter(c,tc,tp)
	if c:IsCode(tc:GetFusionCode()) then return false end
	return c:IsType(TYPE_MONSTER) and (c:IsSetCard(0x1f) or c:IsSetCard(0x3008) or c:IsLevel(10))
end
function s.fstg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and s.tgfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(s.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.tgfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
end
function s.neosfilter(c)
	return c:IsCode(89943723) and (c:IsFaceup() or not c:IsOnField())
end
function s.fsop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local cg=Duel.SelectMatchingCard(tp,s.cfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,tc,tp):GetFirst()
	if cg==nil then return end
	Duel.ConfirmCards(1-tp,cg)
	local code1,code2=cg:GetOriginalCodeRule()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ADD_FUSION_CODE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CLIENT_HINT)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e1:SetValue(code1)
	tc:RegisterEffect(e1)
	if code2 then
		local e2=e1:Clone()
		e2:SetValue(code2)
		tc:RegisterEffect(e2)
	end
	if Duel.IsExistingMatchingCard(s.neosfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil) then
		Duel.SendtoGrave(cg,REASON_EFFECT)
	elseif cg:IsLocation(LOCATION_HAND) then
		Duel.SendtoDeck(cg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
