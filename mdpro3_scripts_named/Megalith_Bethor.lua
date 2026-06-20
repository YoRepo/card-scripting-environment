--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 巨石遗物·贝托尔  (ID: 99628747)
-- Type: Monster / Effect / Ritual
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 1500 | DEF 2600
-- Setcode: 312
--
-- Effect Text:
-- 「巨石遗物」卡降临。这个卡名的①②的效果1回合各能使用1次。
-- ①：把这张卡从手卡丢弃才能发动。等级合计直到变成仪式召唤的怪兽的等级以上为止，把自己的手卡·场上的怪兽解放，从手卡把1只「巨石遗物」仪式怪兽仪式召唤。
-- ②：这张卡仪式召唤成功的场合，以最多有自己墓地的仪式怪兽种类数量的对方场上的卡为对象才能发动。那些卡破坏。
--[[ __CARD_HEADER_END__ ]]

--メガリス・ベトール
function c99628747.initial_effect(c)
	c:EnableReviveLimit()
	--ritual summon
	local e1=aux.AddRitualProcGreater2(c,c99628747.filter,nil,nil,c99628747.matfilter,true)
	e1:SetDescription(aux.Stringid(99628747,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCode(0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,99628747)
	e1:SetCost(c99628747.rscost)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(99628747,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,99628748)
	e2:SetCondition(c99628747.descon)
	e2:SetTarget(c99628747.destg)
	e2:SetOperation(c99628747.desop)
	c:RegisterEffect(e2)
end
function c99628747.filter(c,e,tp,chk)
	return c:IsSetCard(0x138) and (not chk or c~=e:GetHandler())
end
function c99628747.matfilter(c,e,tp,chk)
	return not chk or c~=e:GetHandler()
end
function c99628747.rscost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c99628747.cfilter(c)
	return c:IsType(TYPE_RITUAL) and c:IsType(TYPE_MONSTER)
end
function c99628747.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_RITUAL)
end
function c99628747.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingMatchingCard(c99628747.cfilter,tp,LOCATION_GRAVE,0,1,nil)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c99628747.cfilter,tp,LOCATION_GRAVE,0,nil)
	local gc=g:GetClassCount(Card.GetCode)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,gc,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c99628747.desop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
