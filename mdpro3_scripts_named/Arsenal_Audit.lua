--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 武器库整理  (ID: 49652661)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：从卡组把最多2张装备魔法卡送去墓地（同名卡最多1张）。
-- ②：把墓地的这张卡除外，以自己场上1只表侧表示怪兽为对象才能发动。把最多2张那只怪兽可以装备的装备魔法卡从自己的手卡·墓地给那只怪兽装备（同名卡最多1张）。只要这个效果把装备魔法卡装备中，那只怪兽给与
-- 对方的战斗伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--武器庫整理
local s,id,o=GetID()
function s.initial_effect(c)
	--send
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.tgtg)
	e1:SetOperation(s.tgop)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetHintTiming(TIMING_END_PHASE)
	e2:SetCountLimit(1,id)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.eqtg)
	e2:SetOperation(s.eqop)
	c:RegisterEffect(e2)
end
function s.tgfilter(c)
	return c:IsType(TYPE_EQUIP) and c:IsAbleToGrave()
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.tgfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,2)
		Duel.SendtoGrave(sg,REASON_EFFECT)
	end
end
function s.eqfilter(c,tc,tp)
	return c:IsAllTypes(TYPE_EQUIP+TYPE_SPELL) and c:CheckEquipTarget(tc) and not c:IsForbidden()
		and c:CheckUniqueOnField(tp,LOCATION_SZONE)
end
function s.mfilter(c,tp)
	return c:IsFaceup() and Duel.IsExistingMatchingCard(s.eqfilter,c:GetControler(),LOCATION_GRAVE+LOCATION_HAND,0,1,nil,c,tp)
end
function s.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and s.mfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.mfilter,tp,LOCATION_MZONE,0,1,nil,tp) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,s.mfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_GRAVE+LOCATION_HAND)
end
function s.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ct=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if ct>2 then ct=2 end
	if tc:IsRelateToChain() and tc:IsFaceup() and tc:IsType(TYPE_MONSTER) and ct>0 then
		local g=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.eqfilter),tp,LOCATION_GRAVE+LOCATION_HAND,0,nil,tc,tp)
		local sg=g:SelectSubGroup(tp,aux.dncheck,false,1,ct)
		if not sg or sg:GetCount()==0 then return end
		for ec in aux.Next(sg) do
			if Duel.Equip(tp,ec,tc,true,true) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_EQUIP)
				e1:SetDescription(aux.Stringid(id,2))
				e1:SetProperty(EFFECT_FLAG_CLIENT_HINT)
				e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
				e1:SetValue(aux.ChangeBattleDamage(1,HALF_DAMAGE))
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				ec:RegisterEffect(e1,true)
			end
		end
		Duel.EquipComplete()
	end
end
