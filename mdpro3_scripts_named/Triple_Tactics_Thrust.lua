--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 三战之号  (ID: 35269904)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：这个回合对方是已把怪兽的效果发动的场合才能发动。从卡组把「三战之号」以外的1张通常魔法·通常陷阱卡在自己场上盖放。这个效果盖放的卡在这个回合不能发动。对方场上有怪兽存在的场合，也能不盖放加入手卡。
--[[ __CARD_HEADER_END__ ]]

--三戦の号
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(id,ACTIVITY_CHAIN,aux.FilterBoolFunction(aux.NOT(Effect.IsActiveType),TYPE_MONSTER))
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCustomActivityCount(id,1-tp,ACTIVITY_CHAIN)~=0
end
function s.filter(c,b1,b2)
	return (c:GetType()==TYPE_SPELL or c:GetType()==TYPE_TRAP) and not c:IsCode(id)
		and (b1 and c:IsSSetable() or b2 and c:IsAbleToHand())
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and not e:GetHandler():IsLocation(LOCATION_SZONE) then ct=ct-1 end
	local b1=ct>0
	local b2=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,b1,b2) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local th=Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local tc=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,true,th):GetFirst()
	if not tc then return end
	local b1=tc:IsSSetable()
	local b2=th and tc:IsAbleToHand()
	if b1 and (not b2 or Duel.SelectOption(tp,1153,1190)==0) then
		Duel.SSet(tp,tc)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
	elseif b2 then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
