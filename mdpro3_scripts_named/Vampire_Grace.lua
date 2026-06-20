--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 吸血鬼·格蕾丝  (ID: 40607210)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 6
-- ATK 2000 | DEF 1200
-- Setcode: 142
--
-- Effect Text:
-- 这张卡在墓地存在，不死族怪兽的效果让自己场上有5星以上的不死族怪兽特殊召唤时，支付2000基本分才能发动。这张卡从墓地特殊召唤。「吸血鬼·格蕾丝」的这个效果1回合只能使用1次。此外，1回合1次，宣言卡
-- 的种类（怪兽·魔法·陷阱）才能发动。对方把宣言的种类的1张卡从卡组送去墓地。
--[[ __CARD_HEADER_END__ ]]

--ヴァンパイア・グレイス
function c40607210.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40607210,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,40607210)
	e1:SetCondition(c40607210.condition)
	e1:SetCost(c40607210.cost)
	e1:SetTarget(c40607210.target)
	e1:SetOperation(c40607210.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40607210,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c40607210.tgtg)
	e2:SetOperation(c40607210.tgop)
	c:RegisterEffect(e2)
end
function c40607210.cfilter(c,tp)
	local typ,race=c:GetSpecialSummonInfo(SUMMON_INFO_TYPE,SUMMON_INFO_RACE)
	return c:IsLevelAbove(5) and c:IsRace(RACE_ZOMBIE) and c:IsControler(tp)
		and typ&TYPE_MONSTER~=0 and race&RACE_ZOMBIE~=0
end
function c40607210.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c40607210.cfilter,1,nil,tp)
end
function c40607210.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,2000) end
	Duel.PayLPCost(tp,2000)
end
function c40607210.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c40607210.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c40607210.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(tp)
	e:SetLabel(op)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_DECK)
end
function c40607210.tgfilter(c,ty)
	return c:IsType(ty) and c:IsAbleToGrave()
end
function c40607210.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=nil
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
	if e:GetLabel()==0 then g=Duel.SelectMatchingCard(1-tp,c40607210.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_MONSTER)
	elseif e:GetLabel()==1 then g=Duel.SelectMatchingCard(1-tp,c40607210.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_SPELL)
	else g=Duel.SelectMatchingCard(1-tp,c40607210.tgfilter,1-tp,LOCATION_DECK,0,1,1,nil,TYPE_TRAP) end
	if g:GetCount()~=0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
