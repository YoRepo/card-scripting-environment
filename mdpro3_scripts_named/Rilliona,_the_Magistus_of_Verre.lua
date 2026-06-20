--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 结晶之大贤者 桑德里永  (ID: 72498838)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level 4
-- ATK 800 | DEF 1800
-- Setcode: 336
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡召唤·特殊召唤成功的场合，可以从以下效果选择1个发动。
-- ●从卡组把1张「大贤者」魔法·陷阱卡加入手卡。
-- ●选除外的1只自己的4星以下的魔法师族怪兽回到墓地。
-- ②：把墓地的这张卡除外，以自己场上1只「大贤者」怪兽为对象才能发动。从自己墓地选1只4星以外的「大贤者」怪兽当作装备卡使用给作为对象的怪兽装备。
--[[ __CARD_HEADER_END__ ]]

--結晶の大賢者サンドリヨン
function c72498838.initial_effect(c)
	--to hand/to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,72498838)
	e1:SetTarget(c72498838.target)
	e1:SetOperation(c72498838.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(72498838,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCountLimit(1,72498839)
	e3:SetCost(aux.bfgcost)
	e3:SetTarget(c72498838.eqtg)
	e3:SetOperation(c72498838.eqop)
	c:RegisterEffect(e3)
end
function c72498838.thfilter(c)
	return c:IsSetCard(0x150) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c72498838.rtfilter(c)
	return c:IsFaceup() and c:IsLevelBelow(4) and c:IsRace(RACE_SPELLCASTER)
end
function c72498838.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local sel=0
		if Duel.IsExistingMatchingCard(c72498838.thfilter,tp,LOCATION_DECK,0,1,nil) then sel=sel+1 end
		if Duel.IsExistingMatchingCard(c72498838.rtfilter,tp,LOCATION_REMOVED,0,1,nil) then sel=sel+2 end
		e:SetLabel(sel)
		return sel~=0
	end
	local sel=e:GetLabel()
	if sel==3 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
		sel=Duel.SelectOption(tp,aux.Stringid(72498838,0),aux.Stringid(72498838,1))+1
	elseif sel==1 then
		Duel.SelectOption(tp,aux.Stringid(72498838,0))
	else
		Duel.SelectOption(tp,aux.Stringid(72498838,1))
	end
	e:SetLabel(sel)
	if sel==1 then
		e:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
		Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	else
		e:SetCategory(CATEGORY_TOGRAVE)
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_REMOVED)
	end
end
function c72498838.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sel=e:GetLabel()
	if sel==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c72498838.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if #g>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c72498838.rtfilter,tp,LOCATION_REMOVED,0,1,1,nil)
		if #g>0 then
			Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
		end
	end
end
function c72498838.tgfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x150)
end
function c72498838.eqfilter(c)
	return c:IsSetCard(0x150) and c:IsType(TYPE_MONSTER) and not c:IsLevel(4)
end
function c72498838.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c72498838.tgfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c72498838.tgfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c72498838.eqfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c72498838.tgfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c72498838.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c72498838.eqfilter),tp,LOCATION_GRAVE,0,1,1,nil)
		local ec=g:GetFirst()
		if ec then
			if not Duel.Equip(tp,ec,tc) then return end
			--equip limit
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetLabelObject(tc)
			e1:SetValue(c72498838.eqlimit)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			ec:RegisterEffect(e1)
		end
	end
end
function c72498838.eqlimit(e,c)
	return c==e:GetLabelObject()
end
