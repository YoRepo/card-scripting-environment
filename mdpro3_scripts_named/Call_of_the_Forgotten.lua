--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 怨念的呼声  (ID: 80749819)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这张卡发动时：可以从自己的卡组·墓地把最多3张「活死人的呼声」在自己场上盖放，直到下个对方回合的结束时，除从墓地的特殊召唤外，自己不是不死族怪兽不能特殊召唤。
-- 1回合1次，自己把「活死人的呼声」发动的场合：可以以对方场上1只怪兽为对象；那只怪兽送去墓地。
-- 「怨念的呼声」在1回合只能发动1张。
--[[ __CARD_HEADER_END__ ]]

--Call of the Forgotten
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,97077563)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--tg
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(s.tgcon)
	e2:SetTarget(s.tgtg)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
end
function s.setfilter(c)
	return c:IsCode(97077563) and c:IsSSetable()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.setfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,nil)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,2)) and ft>0 then
		local ct=math.min(3,ft)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
		local sg=g:Select(tp,1,ct,nil)
		Duel.SSet(tp,sg)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(id,3))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
		e1:SetTargetRange(1,0)
		e1:SetTarget(s.slim)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.slim(e,c,sp,st,spos,tp,se)
	return not c:IsLocation(LOCATION_GRAVE) and not c:IsRace(RACE_ZOMBIE)
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsCode(97077563) and rp==tp
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToGrave,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToGrave,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToChain() then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
