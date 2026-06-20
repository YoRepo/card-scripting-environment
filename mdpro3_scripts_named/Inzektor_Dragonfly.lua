--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 甲虫装机 豆娘  (ID: 68184115)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Insect
-- Level 3
-- ATK 1000 | DEF 1800
-- Setcode: 86
--
-- Effect Text:
-- ①：1回合1次，自己主要阶段才能发动。从自己的手卡·墓地选1只「甲虫装机」怪兽当作装备卡使用给这张卡装备。
-- ②：这张卡在自己场上存在，给这张卡装备的卡被送去自己墓地的场合才能发动。从卡组把「甲虫装机 豆娘」以外的1只「甲虫装机」怪兽特殊召唤。
-- ③：把这张卡当作装备卡使用来装备的怪兽的等级上升3星。
--[[ __CARD_HEADER_END__ ]]

--甲虫装機 ダンセル
function c68184115.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68184115,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c68184115.eqtg)
	e1:SetOperation(c68184115.eqop)
	c:RegisterEffect(e1)
	--equip effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetValue(3)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(68184115,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c68184115.spcon)
	e3:SetTarget(c68184115.sptg)
	e3:SetOperation(c68184115.spop)
	c:RegisterEffect(e3)
end
function c68184115.filter(c)
	return c:IsSetCard(0x56) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c68184115.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c68184115.filter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function c68184115.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c68184115.filter),tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		if not Duel.Equip(tp,tc,c) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c68184115.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c68184115.eqlimit(e,c)
	return e:GetOwner()==c
end
function c68184115.cfilter(c,ec,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c:GetEquipTarget()==ec
end
function c68184115.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c68184115.cfilter,1,nil,e:GetHandler(),tp)
end
function c68184115.spfilter(c,e,tp)
	return c:IsSetCard(0x56) and not c:IsCode(68184115) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c68184115.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsFaceup()
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c68184115.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c68184115.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c68184115.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
