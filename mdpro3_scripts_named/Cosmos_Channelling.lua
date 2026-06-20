--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 与宇宙的交信  (ID: 91654806)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：把原本持有者是对方的自己场上1只怪兽送去墓地才能发动。从自己的手卡·墓地选1只机械族怪兽特殊召唤。
-- ②：自己场上有「人造人-念力震慑者」存在，对方抽卡阶段对方通常抽卡时，宣言卡的种类（怪兽·魔法·陷阱）才能发动。抽到的卡给双方确认，宣言的种类的场合，这张卡送去墓地，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--宇宙との交信
function c91654806.initial_effect(c)
	aux.AddCodeList(c,77585513)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91654806,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCountLimit(1,91654806)
	e1:SetCost(c91654806.spcost)
	e1:SetTarget(c91654806.sptg)
	e1:SetOperation(c91654806.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91654806,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,91654807)
	e2:SetCondition(c91654806.drcon)
	e2:SetTarget(c91654806.drtg)
	e2:SetOperation(c91654806.drop)
	c:RegisterEffect(e2)
end
function c91654806.tgfilter(c,tp)
	return c:GetOwner()~=tp and c:IsAbleToGraveAsCost() and Duel.GetMZoneCount(tp,c)>0
end
function c91654806.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(100)
	if chk==0 then return Duel.IsExistingMatchingCard(c91654806.tgfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c91654806.tgfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SendtoGrave(g,REASON_COST)
end
function c91654806.spfilter(c,e,tp)
	return c:IsRace(RACE_MACHINE) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c91654806.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local res=e:GetLabel()==100 or Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	if chk==0 then
		e:SetLabel(0)
		return res and Duel.IsExistingMatchingCard(c91654806.spfilter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_GRAVE)
end
function c91654806.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c91654806.spfilter),tp,LOCATION_HAND+LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c91654806.confilter(c)
	return c:IsFaceup() and c:IsCode(77585513)
end
function c91654806.drcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and r==REASON_RULE and Duel.IsExistingMatchingCard(c91654806.confilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c91654806.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGrave() and Duel.IsPlayerCanDraw(tp,1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	e:SetLabel(Duel.AnnounceType(tp))
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,e:GetHandler(),0,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,0)
end
function c91654806.drop(e,tp,eg,ep,ev,re,r,rp)
	if not eg:IsExists(Card.IsLocation,1,nil,LOCATION_HAND) then return end
	local opt=e:GetLabel()
	local g=eg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	Duel.ConfirmCards(tp,g)
	Duel.ShuffleHand(1-tp)
	local res=false
	local tc=g:GetFirst()
	while tc do
		if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
			res=true
		end
		tc=g:GetNext()
	end
	local c=e:GetHandler()
	if res and Duel.SendtoGrave(c,REASON_EFFECT)~=0 and c:IsLocation(LOCATION_GRAVE) then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
